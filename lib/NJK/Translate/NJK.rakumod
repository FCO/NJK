use NJK::AST;
use NJK::AST::HTMLTagBody;
use NJK::AST::HTMLTagVoid;
use NJK::AST::HTMLText;
use NJK::AST::Unit;
use NJK::AST::StatementBlock;
unit class NJK::Translate::NJK;

proto method translate(NJK::AST --> Str) {*}

multi method translate(NJK::AST::Unit $_) {
  self.translate: .block
}

multi method translate(NJK::AST::StatementBlock $_) {
  [ self.translate: $_ for .parts ].join: "\n"
}

sub translate-tag(Str $tag-name, %params) {
  "<{ $tag-name }{ " " ~ %params.kv.map(-> $key, $value { qq|$key="$value.Str()"| }).join: " " if %params }>"
}

multi method translate(NJK::AST::HTMLTagVoid $_) {
  translate-tag .tag-name, .params
}

multi method translate(NJK::AST::HTMLText $_) {
  .value
}

