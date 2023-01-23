use NJK::AST;
use NJK::AST::Logic;
unit class NJK::AST::For does NJK::AST;

has NJK::AST @.iterating;
has NJK::AST $.iterator;
has NJK::AST @.block;
has NJK::AST @.else;

