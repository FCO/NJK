use NJK::AST;
use NJK::AST::StatementBlock;
use NJK::AST::Logic;
unit class NJK::AST::For does NJK::AST;

has NJK::AST                 @.iterating;
has NJK::AST                 $.iterator;
has NJK::AST::StatementBlock $.block;
has NJK::AST::StatementBlock $.else;

