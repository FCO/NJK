use NJK::AST::LogicInfixOp;
use NJK::AST::LogicBoolean;
use NJK::AST::LogicNumeric;
use NJK::AST::LogicQuoted;
use NJK::AST::LogicFuncCall;
use NJK::AST::LogicArray;
use NJK::AST::HTMLTagVoid;
use NJK::AST::HTMLTagBody;
use NJK::AST::HTMLText;
use NJK::AST::Value;
use NJK::AST::Filter;
use NJK::AST::Unit;

use NJK::Actions::Variables;
use NJK::Actions::If;
use NJK::Actions::For;
use NJK::Actions::Block;
use NJK::Actions::Extends;
use NJK::Actions::Include;
use NJK::Actions::Macro;
use NJK::Actions::Type;

unit class NJK::Actions;
also does NJK::Actions::Variables;
also does NJK::Actions::If;
also does NJK::Actions::For;
also does NJK::Actions::Block;
also does NJK::Actions::Extends;
also does NJK::Actions::Include;
also does NJK::Actions::Macro;
also does NJK::Actions::Type;

method TOP($/) {
  make NJK::AST::Unit.new: block => $<block>.made, inputs => %*INPUTS
}

method block($/) {
  make NJK::AST::StatementBlock.new: parts => @<part>».made, variables => %*VARIABLES, blocks => %*BLOCKS
}

method part($/) {
  make (
    $<value> // $<statement> // $<html>
  ).made
}

method njk-tag($/) {
  make $<regex>.kv.map(-> Str $key, \data {
    $key => data ~~ Positional ?? data».made !! data.made
  }).Map
}

method njk-block($/) {
  make %(
    inside-tag => $<opening-tag>,
    block      => $<block>
  )
}

method file($/) {
  make $<want>.made.value
}

method quoted-file:sym<double>($/) { make ~$<value> }
method quoted-file:sym<single>($/) { make ~$<value> }

method value($/) {
  make NJK::AST::Value.new: value => $<want>.made, filters => $<filter>.map: { NJK::AST::Filter.new: :name(~.<name>), :params[.<param>».made] }
}

method want($/) {
  make $<logic>.made
}

method logic:sym<op1>($/)   { make NJK::AST::LogicInfixOp.new: left => $<logic-basic>.made, op => $<logic-op1>.made, right => $<want>.made }
method logic:sym<op2>($/)   { make NJK::AST::LogicInfixOp.new: left => $<logic-basic>.made, op => $<logic-op2>.made, right => $<want>.made }
method logic:sym<basic>($/) { make $<logic-basic>.made }

method logic-op1:sym<*>($/) { make ~$<sym> }
method logic-op1:sym</>($/) { make ~$<sym> }

method logic-op2:sym<+>($/) { make ~$<sym> }
method logic-op2:sym<->($/) { make ~$<sym> }

method logic-basic:sym<bool>($/)   { make NJK::AST::LogicBoolean.new(value => ($/.Str.trim eq "true")) }
method logic-basic:sym<num>($/)    { make NJK::AST::LogicNumeric.new: value => +$/ }
method logic-basic:sym<quote>($/)  { make NJK::AST::LogicQuoted.new: value => ~$<value> }
method logic-basic:sym<dquote>($/) { make NJK::AST::LogicQuoted.new: value => ~$<value>, :double }
method logic-basic:sym<func>($/)   { make NJK::AST::LogicFuncCall.new: name => ~$<name>, params => $<param>».made }
method logic-basic:sym<array>($/)  { make NJK::AST::LogicArray.new: values => $<value>».made }

# proto rule statement {*}

method html($/) {
  make ($<html-tag> // $<html-text>).made
}

method html-text($/) { make NJK::AST::HTMLText.new: value => ~$/ }

method html-tag($/) {
  make ($<tag-void> // $<tag-body>).made
}

method tag-void($/) {
  make NJK::AST::HTMLTagVoid.new:
    :tag-name($<tag-void-name>.made),
    :params($<html-param-list>.made)
}

method tag-body($/) {
  make NJK::AST::HTMLTagBody.new:
    :tag-name(~$<tag-body-name>),
    :params($<html-param-list>.made),
    :body($<part>».made)
}

method html-param-list($/) {
  make %( |@<html-param>».made )
}

method html-param($/) {
  make ~$<html-param-key> => $<html-param-value>.made
}

method html-param-value:sym<word>($/)   { make ~$/ }
method html-param-value:sym<quote>($/)  { make ~$<value> }
method html-param-value:sym<dquote>($/) { make ~$<value> }

method tag-void-name:sym<area>($/)    { make ~$<sym> }
method tag-void-name:sym<base>($/)    { make ~$<sym> }
method tag-void-name:sym<br>($/)      { make ~$<sym> }
method tag-void-name:sym<col>($/)     { make ~$<sym> }
method tag-void-name:sym<command>($/) { make ~$<sym> }
method tag-void-name:sym<embed>($/)   { make ~$<sym> }
method tag-void-name:sym<hr>($/)      { make ~$<sym> }
method tag-void-name:sym<img>($/)     { make ~$<sym> }
method tag-void-name:sym<input>($/)   { make ~$<sym> }
method tag-void-name:sym<keygen>($/)  { make ~$<sym> }
method tag-void-name:sym<link>($/)    { make ~$<sym> }
method tag-void-name:sym<meta>($/)    { make ~$<sym> }
method tag-void-name:sym<param>($/)   { make ~$<sym> }
method tag-void-name:sym<source>($/)  { make ~$<sym> }
method tag-void-name:sym<track>($/)   { make ~$<sym> }
method tag-void-name:sym<wbr>($/)     { make ~$<sym> }

