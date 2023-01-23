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
  <[a..zA..Z]><[a..zA..Z0..9_]>*
}

rule variable {
  <[a..zA..Z]><[a..zA..Z0..9_]>+
}
