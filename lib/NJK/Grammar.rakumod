use NJK::Grammar::If;
use NJK::Grammar::For;
use NJK::Grammar::Block;
use NJK::Grammar::Variables;
use NJK::Grammar::Extends;
use NJK::Grammar::Include;
use NJK::Grammar::Type;
use X::NJK::ParsingError;

unit grammar NJK::Grammar;
also does NJK::Grammar::If;
also does NJK::Grammar::For;
also does NJK::Grammar::Block;
also does NJK::Grammar::Variables;
also does NJK::Grammar::Extends;
also does NJK::Grammar::Include;
also does NJK::Grammar::Type;

rule TOP {
  :my %*INPUTS;
  <block>
}

rule block {
  :my %*VARIABLES;
  :my %*BLOCKS;
  <part>*
}

rule part {
  | <value>
  | <statement>
  | <html>
}

token file(:$no-error) {
  [
    || <quoted-file> <?{ $<quoted-file><value>.Str.IO.e }>
    || <?{ $no-error }>
    || <.error("File \o33[31m$<quoted-file><value>\o33[m does not exist")>
  ]
}

proto token quoted-file {*}
      token quoted-file:sym<double> { '"' ~ '"' $<value>=[<-["]>*] }
      token quoted-file:sym<single> { "'" ~ "'" $<value>=[<-[']>*] }

rule value {
  '{{' ~ '}}' [ <logic> ['|' <filter>]* || <.error("Error on value")> ]
}

rule filter {
  $<name>=\w+ [ "(" ~ ")" [ <param=.logic>* %% ',' ] ]?
}

proto rule logic {*}
      rule logic:sym<op1>   { <logic-basic> <logic-op1> <logic> }
      rule logic:sym<op2>   { <logic-basic> <logic-op2> <logic> }
      rule logic:sym<basic> { <logic-basic> }
      rule logic:sym<var>   { <variable> }

proto token logic-op1 {*}
      token logic-op1:sym<*> { <sym> }
      token logic-op1:sym</> { <sym> }

proto token logic-op2 {*}
      token logic-op2:sym<+> { <sym> }
      token logic-op2:sym<-> { <sym> }

proto rule logic-basic {*}
      rule logic-basic:sym<num>    { <[+-]>? \d+[.\d+]? }
      rule logic-basic:sym<quote>  { "'" ~ "'" $<value>=<-[']>+ } # TODO: Fix
      rule logic-basic:sym<dquote> { '"' ~ '"' $<value>=<-["]>+ } # TODO: Fix
      rule logic-basic:sym<func>   { $<name>=\w+["(" ~ ")" [ <param=.logic>* % ',' ]] }
      rule logic-basic:sym<array>  { "[" ~ "]" <value=.logic>* %% ',' }

proto rule statement {*}

token html {
  | <html-tag>
  | <html-text>
}

token html-text {
  <-[<{]>+
}

token html-tag {
  | <tag-void>
  | <tag-body>
}

token tag-void {
  <.ws> "<" ~ ">" [<tag-void-name> <.ws> <html-param-list>] <.ws>
}

token tag-body {
  <.ws>
  [ "<" ~ ">" [$<tag-body-name>=\w+ <.ws> <html-param-list>]]
  ~
  ["</" ~ ">" $<tag-body-name>]
  <part>*
  <.ws>
}

token html-param-list {
  <html-param>* %% <.ws>
}

token html-param {
  $<html-param-key>=\w+ '=' <html-param-value>
}

proto token html-param-value {*}
      token html-param-value:sym<word>   { \w+ }
      token html-param-value:sym<quote>  { "'" ~ "'" $<value>=<-[']>* } # TODO: Fix
      token html-param-value:sym<dquote> { '"' ~ '"' $<value>=<-["]>* } # TODO: Fix

proto token tag-void-name {*}
      token tag-void-name:sym<area>    { <sym> }
      token tag-void-name:sym<base>    { <sym> }
      token tag-void-name:sym<br>      { <sym> }
      token tag-void-name:sym<col>     { <sym> }
      token tag-void-name:sym<command> { <sym> }
      token tag-void-name:sym<embed>   { <sym> }
      token tag-void-name:sym<hr>      { <sym> }
      token tag-void-name:sym<img>     { <sym> }
      token tag-void-name:sym<input>   { <sym> }
      token tag-void-name:sym<keygen>  { <sym> }
      token tag-void-name:sym<link>    { <sym> }
      token tag-void-name:sym<meta>    { <sym> }
      token tag-void-name:sym<param>   { <sym> }
      token tag-void-name:sym<source>  { <sym> }
      token tag-void-name:sym<track>   { <sym> }
      token tag-void-name:sym<wbr>     { <sym> }



method error($msg) {
  my $parsed-so-far = self.target.substr(0, self.pos);
  my @lines = $parsed-so-far.lines;
  my $break = self.pos + 15;
  my $not-parsed = self.target.substr: self.pos, $break;
  X::NJK::ParsingError.new(
    :error($msg),
    :line-no(@lines.elems),
    :last-line(@lines[*-1]),
    :$not-parsed,
  ).throw
}
