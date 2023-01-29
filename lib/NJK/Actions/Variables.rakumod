use NJK::AST::DeclareVar;
use NJK::AST::UseVariable;
use NJK::AST::Set;
use NJK::AST::Input;
unit role NJK::Actions::Variables;

method statement:sym<input>($/) {
  make NJK::AST::Input.new: :variable($<declare-var>.made)
}

method statement:sym<set>($/) {
  make NJK::AST::Set.new: :variable($<declare-var>.made), :value($<logic>.made)
}

method statement:sym<set-block>($/) {
  make NJK::AST::SetBlock.new: :variable($<declare-var>.made), :value($<part>.made)
}

method var-name($/) {
  make $/.Str.trim
}

method declare-var($/) {
  make NJK::AST::DeclareVar.new: name => $<var-name>.made
}

method variable($/) {
  make NJK::AST::UseVariable.new: name => $/.Str.trim
}
