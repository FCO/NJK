use NJK::AST::For;

unit role NJK::Actions::For;

method statement:sym<for>($/) {
  make NJK::AST::For.new:
    :iterating($<iterating>».made),
    :iterator($<iterator>.made),
    :block($<block>.made),
    :else($<else>.made),
}

method for-else($/) {
  make $<block>.made
}

