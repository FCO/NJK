unit role NJK::Grammar::If;

rule statement:sym<if> {
  <njk-block(
    "if",
    /<condition=.want("boolean|number")>/,
    /
      <block>
      <elif=.if-elif>*
      <else=.if-else>?
    /
  )>
}

rule if-else {
  <njk-tag("else")>
  <block>
}

rule if-elif {
  <njk-tag("elif", /<want>/)>
  <block>
}
