use NJK::AST::DeclareVar;
use NJK::AST;
unit class NJK::AST::SetBlock does NJK::AST;

has NJK::AST::DeclareVar $.variable;
has NJK::AST             $.value;
