unit class X::NJK::ParsingError is Exception;

has Str  $.error;
has UInt $.line-no;
has Str  $.last-line;
has Str  $.not-parsed;

has Str $.message = "Compiling ERROR on line $!line-no:\n$!error: \o033[32m$!last-line.trim-leading()\o033[33m⏏\o033[31m$!not-parsed\o033[m";
