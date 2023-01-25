unit role NJK::Grammar::Extends;

rule statement:sym<extends> {
  '{%' ~ '%}' [ "extends" [ <file> || <.error("Error on extends")> ] ]
}
