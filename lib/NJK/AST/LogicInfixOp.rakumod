use NJK::AST::Logic;
unit class NJK::AST::LogicInfixOp does NJK::AST::Logic;

has NJK::AST::Logic $.left;
has NJK::AST::Logic $.right;
has Str             $.op;
