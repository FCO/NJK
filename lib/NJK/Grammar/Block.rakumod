unit role NJK::Grammar::Block;

rule statement:sym<block> {
  '{%' ~ '%}' [ "block" $<name>=\w+ ]
  <block=.part>*
  '{%' ~ '%}' "endblock"
}
