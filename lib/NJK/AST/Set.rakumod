use NJK::AST::DeclareVar;
use NJK::AST::Logic;
use NJK::AST;
unit class NJK::AST::Set does NJK::AST;

has NJK::AST::DeclareVar $.variable;
has NJK::AST::Logic      $.value;
