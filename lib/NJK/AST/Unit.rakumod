use NJK::AST;
use NJK::AST::StatementBlock;

unit class NJK::AST::Unit does NJK::AST;

has NJK::AST::StatementBlock $.block;
has                          %.inputs;
