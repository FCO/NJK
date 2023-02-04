use NJK::AST::DeclareVar;
use NJK::AST::UseVariable;
use NJK::AST::Set;
use NJK::AST::Input;
unit role NJK::Actions::Variables;

method statement:sym<input>($/) {
  make NJK::AST::Input.new: :variable($<njk-tag>.made<declare-var>)
}

method statement:sym<set>($/) {
  my %tag := $<njk-tag>.made;
  make NJK::AST::Set.new: :variable(%tag<declare-var>), :value(%tag<logic>)
}

method statement:sym<set-block>($/) {
  my %made   := $<njk-block>.made;
  my %inside := %made<inside-tag>.made;
  make NJK::AST::SetBlock.new: :variable($<njk-block><inside-tag>.made<declare-var>), :value(%made<block><part>.made)
}

method var-name($/) {
  make $/.Str.trim
}

method declare-var($/) {
  require ::("NJK::Type");
  make NJK::AST::DeclareVar.new: name => $<var-name>.made, type => $<type>.made // ::("NJK::Type").new: "any"
}

method variable($/) {
  make NJK::AST::UseVariable.new: name => $/.Str.trim
}
