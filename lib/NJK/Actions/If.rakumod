use NJK::AST::If;
unit role NJK::Actions::If;

method statement:sym<if>($/) {
  make NJK::AST::If.new:
    :condition($<condition>.made),
    :block($<block>.made),
    :elif($<elif>».made),
    :else($<else>.made),
}

method if-else($/) {
  make $<block>.made
}

method if-elif($/) {
  make ($<logic>.made => $<block>.made)
}
