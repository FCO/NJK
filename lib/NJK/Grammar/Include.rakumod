unit role NJK::Grammar::Include;

rule statement:sym<include> {
  # TODO: Fix no-error
  '{%' ~ '%}' [ "include" [ <file(:no-error)> || <.error("Error on include")> ] $<no-error>=[ "ignore" "missing" ]? ]
}
