unit role NJK::Grammar::For;

rule statement:sym<for> {
  :my %*PARENT-VARIABLES = |CALLERS::<%*VARIABLES>, |CALLERS::<%*PARENT-VARIABLES>.?pairs;
  :my %*VARIABLES;
  <njk-block(
    "for",
    /<iterating=.declare-var>+ % [<.ws> ',' <.ws>] in <.ws> <iterator=.variable>/,
    /
      <block>
      <else=.for-else>?
    /
  )>
}

rule for-else {
  <njk-tag("else")>
  <block>
}
