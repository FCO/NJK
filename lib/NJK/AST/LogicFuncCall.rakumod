use NJK::AST::Logic;

unit class NJK::AST::LogicFuncCall does NJK::AST::Logic;

has Str             $.name;
has NJK::AST::Logic @.params;
