unit role NJK::Grammar::Variables;

rule statement:sym<input> {
  '{%' ~ '%}' [ "input" <declare-var> ]
  {
    require ::("NJK::Type");
    %*VARIABLES{$<declare-var><var-name>.Str.trim} = ::("NJK::Type").new: ($<declare-var><type>.defined ?? $<declare-var><type> !! "any").Str;
    %*INPUTS{$<declare-var><var-name>.Str.trim}    = ::("NJK::Type").new: ($<declare-var><type>.defined ?? $<declare-var><type> !! "any").Str;
  }
}

rule statement:sym<set> {
  :my $*LAST-TYPE;
  '{%' ~ '%}' [ "set" <declare-var> "=" <logic> ]
  {
    require ::("NJK::Type");
    %*VARIABLES{$<declare-var><var-name>.Str.trim} = do with $<declare-var><type> -> $type {
      ::("NJK::Type").new: $type
    } elsif $*LAST-TYPE {
      $*LAST-TYPE
    } else {
      ::("NJK::Type").new: "any"
    }
  }
}

rule statement:sym<set-block> {
  '{%' ~ '%}' [ "set" <declare-var> ]
  <part>*
  '{%' ~ '%}' "endset"
}

token var-name {
  <[a..zA..Z_]><[a..zA..Z0..9_]>*
}

rule declare-var {
  <var-name> [ ":" <type> ]?
}

rule variable {
  :my @vars = |%*VARIABLES.keys, |(%*PARENT-VARIABLES // %()).keys;
  @vars || <var-name> && <error("Variable not defined")>
}
