unit role NJK::Grammar::If;

rule statement:sym<if> {
  '{%' ~ '%}' [ if <condition=.want("boolean|number")> ]
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
  '{%' ~ '%}' [ "elif" <want> ]
  <block>
}
