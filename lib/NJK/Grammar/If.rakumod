unit role NJK::Grammar::If;

rule statement:sym<if> {
  '{%' ~ '%}' [ if <condition=.logic> ]
  <block=.part>*
  <elif=.if-elif>*
  <else=.if-else>?
  '{%' ~ '%}' "endif"
}

rule if-else {
  '{%' ~ '%}' "else"
  <part>*
}

rule if-elif {
  '{%' ~ '%}' [ "elif" <logic> ]
  <part>*
}
