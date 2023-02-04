use NJK::AST::If;
unit role NJK::Actions::If;

method statement:sym<if>($/) {
  my %made := $<njk-block>.made;
  make NJK::AST::If.new:
    :condition(%made<inside-tag>.made<condition>),
    :block(%made<block><block>.made),
    :elif(%made<block><elif>».made),
    :else(%made<block><else>.made),
}

method if-else($/) {
  make $<block>.made
}

method if-elif($/) {
  make ($<njk-tag>.made<want> => $<block>.made)
}
