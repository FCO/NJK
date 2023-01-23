use NJK::AST;
unit class NJK::AST::Block does NJK::AST;

has Str      $.name;
has NJK::AST @.block;
