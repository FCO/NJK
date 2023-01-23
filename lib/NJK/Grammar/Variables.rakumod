unit role NJK::Grammar::Variables;

rule statement:sym<set> {
  '{%' ~ '%}' [ "set" <declare-var> "=" <logic> ]
}

rule statement:sym<set-block> {
  '{%' ~ '%}' [ "set" <declare-var> ]
  <part>*
  '{%' ~ '%}' "endset"
}

rule declare-var {
  <[a..zA..Z_]><[a..zA..Z0..9_]>*
  { %*VARIABLES{$/} = True }
}

rule variable {
  :my @vars = %*VARIABLES.keys;
  @vars || <[a..zA..Z_]><[a..zA..Z0..9_]>+ && <error("Variable not defined")>
}
