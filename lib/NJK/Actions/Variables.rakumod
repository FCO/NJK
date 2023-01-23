use NJK::AST::DeclareVar;
use NJK::AST::UseVariable;
use NJK::AST::Set;
unit role NJK::Actions::Variables;

method statement:sym<set>($/) {
  make NJK::AST::Set.new: :variable($<declare-var>.made), :value($<logic>.made)
}

method statement:sym<set-block>($/) {
  make NJK::AST::SetBlock.new: :variable($<declare-var>.made), :value($<part>.made)
}

method declare-var($/) {
  make NJK::AST::DeclareVar.new: name => ~$/
}

method variable($/) {
  make NJK::AST::UseVariable.new: name => ~$/
}
