use NJK::AST::Block;

unit role NJK::Actions::Block;

method statement:sym<block>($/) {
  make %*BLOCKS{$<name>} = NJK::AST::Block.new:
    :name(~$<name>),
    :block($<block>».made),
}
