use NJK::AST;
use NJK::AST::Logic;
unit class NJK::AST::Filter does NJK::AST;

has Str             $.name is required;
has NJK::AST::Logic @.params;
