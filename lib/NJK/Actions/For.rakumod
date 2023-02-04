use NJK::AST::For;

unit role NJK::Actions::For;

method statement:sym<for>($/) {
  my %made   := $<njk-block>.made;
  my %inside := %made<inside-tag>.made;
  make NJK::AST::For.new:
    :iterating(%inside<iterating>),
    :iterator(%inside<iterator>),
    :block(%made<block><block>.made),
    :else(%made<block><else>.made),
}

method for-else($/) {
  make $<block>.made
}

