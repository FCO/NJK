unit role NJK::Grammar::For;

rule statement:sym<for> {
  :my %*PARENT-VARIABLES = |CALLERS::<%*VARIABLES>, |CALLERS::<%*PARENT-VARIABLES>.?pairs;
  :my %*VARIABLES;
  '{%' ~ '%}' [ "for" <iterating=.declare-var>+ % ',' in <iterator=.variable> ]
  <block>
  <else=.for-else>?
  '{%' ~ '%}' "endfor"
}

rule for-else {
  '{%' ~ '%}' "else"
  <block>
}
