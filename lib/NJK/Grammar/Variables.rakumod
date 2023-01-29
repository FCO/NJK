unit role NJK::Grammar::Variables;

rule statement:sym<input> {
  '{%' ~ '%}' [ "input" <declare-var(:input)> ]
}

rule statement:sym<set> {
  '{%' ~ '%}' [ "set" <declare-var> "=" <logic> ]
}

rule statement:sym<set-block> {
  '{%' ~ '%}' [ "set" <declare-var> ]
  <part>*
  '{%' ~ '%}' "endset"
}

token var-name {
  <[a..zA..Z_]><[a..zA..Z0..9_]>*
}

rule declare-var(:$input) {
  <var-name>
  [ ":" <type> ]?
  {
    require ::("NJK::Type");
    %*VARIABLES{$<var-name>.Str.trim} = ::("NJK::Type").new: ($<type>.defined ?? $<type> !! "any").Str;
    %*INPUTS{$<var-name>.Str.trim}    = ::("NJK::Type").new: ($<type>.defined ?? $<type> !! "any").Str if $input;
  }
}

rule variable {
  :my @vars = |%*VARIABLES.keys, |(%*PARENT-VARIABLES // %()).keys;
  @vars || <var-name> && <error("Variable not defined")>
}
