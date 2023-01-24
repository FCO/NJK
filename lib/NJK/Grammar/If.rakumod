unit role NJK::Grammar::If;

rule statement:sym<if> {
  '{%' ~ '%}' [ if <condition=.logic> ]
  <block>
  <elif=.if-elif>*
  <else=.if-else>?
  '{%' ~ '%}' "endif"
}

rule if-else {
  '{%' ~ '%}' "else"
  <block>
}

rule if-elif {
  '{%' ~ '%}' [ "elif" <logic> ]
  <block>
}
