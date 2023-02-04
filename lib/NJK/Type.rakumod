use NJK::Grammar::Type;
unit class NJK::Type;

class Single {
  has Str       $.name;
  has Str       $.return = $!name;
  has NJK::Type $.sub-type;

  method gist {
    "$!name" ~ "{ "[{ .gist }]" with $!sub-type }"
  }

  multi method ACCEPTS(::?CLASS:U: Single) {
    True
  }

  multi method ACCEPTS(::?CLASS:D: Single $_) {
    # say "1: { .gist } ~~ { self.gist }";
    return True if $!return eq "any";
    # say "$!return eq { .name }";
    return False unless $!return eq .return;
    return False if !$!sub-type && .sub-type;
    .sub-type ~~ $!sub-type
  }
}

class Enum is Single {
  has Str @.opts;

  method gist { "enum({ @!opts.join(", ") })" }
}

class Function is Single {
  has NJK::Type @.positional-params;
  has NJK::Type %.named-params; # TODO

  method gist { "function({ @!positional-params».gist.join: ", " }):$.return" }
}

has Single @.single-types;

multi method gist(::?CLASS:D:) {
  @!single-types».gist.join: "|"
}

proto method new(|) {*}
multi method new(Str $_) {
  my $grammar     = grammar {} but NJK::Grammar::Type;
  my Match $match = $grammar.parse: :rule<type>, $_;
  self.new: $match
}

multi method new(Match:D $/) {
  self.bless: :single-types(
    $<type-opt>.map: {
      return Function.new(
        :name<function>,
        :return((.<type-name><return> // "string").Str),
        :positional-params(.<type-name><positional-params>.map: { ::?CLASS.new: $_ }),
      ) if .<type-name><sym> eq "function";
      return Enum.new(
        :name<enum>,
        :return<string>,
        :opts(.<type-name><enum-opt>».Str)
      ) if .<type-name><sym> eq "enum";
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
