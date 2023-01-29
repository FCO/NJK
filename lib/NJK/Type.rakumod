use NJK::Grammar;
unit class NJK::Type;

class Single {
  has Str       $.name;
  has NJK::Type $.sub-type;

  method gist {
    "$!name" ~ "{ "[{ .gist }]" with $!sub-type }"
  }

  multi method ACCEPTS(::?CLASS:U: Single) {
    True
  }

  multi method ACCEPTS(::?CLASS:D: Single $_) {
    # say "1: { .gist } ~~ { self.gist }";
    return True if $!name eq "any";
    return False unless $!name eq .name;
    return False if !$!sub-type && .sub-type;
    .sub-type ~~ $!sub-type
  }
}

has Single @.single-types;

multi method gist(::?CLASS:D:) {
  @!single-types».gist.join: "|"
}

proto method new(|) {*}
multi method new(Str $_) {
  self.new: NJK::Grammar.parse: :rule<type>, $_;
}

multi method new(Match $/) {
  self.bless: :single-types(
    $<type>.map: {
      Single.new:
        :name(~(.<type-name> // "any")),
        |(:sub-type(NJK::Type.new: $_) with .<type>)
      }
    )
  ;
}

multi method ACCEPTS(::?CLASS:U: NJK::Type:D) {
  True
}

multi method ACCEPTS(::?CLASS:D: NJK::Type:D $_) {
  # say "2: { .gist } ~~ { self.gist }";
  return False if .single-types > 1;

  .single-types.head ~~ self
}

multi method ACCEPTS(::?CLASS:D: Single $_) {
  # say "3: { .gist } ~~ { self.gist }";
  any(@!single-types).ACCEPTS($_)
}
