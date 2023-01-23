unit role NJK::Grammar::For;

rule statement:sym<for> {
  '{%' ~ '%}' [ "for" <iterating=.declare-var>+ % ',' in <iterator=.variable> ]
  <block=.part>*
  <else=.for-else>?
  '{%' ~ '%}' "endfor"
}

rule for-else {
  '{%' ~ '%}' "else"
  <block=.part>*
}
