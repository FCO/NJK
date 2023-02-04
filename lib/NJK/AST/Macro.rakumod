use NJK::Type;
use NJK::AST::StatementBlock;
use NJK::AST::Logic;
unit class NJK::AST::Macro does NJK::AST;

has NJK::Type                @.positional-params;
has NJK::AST::StatementBlock $.block;
