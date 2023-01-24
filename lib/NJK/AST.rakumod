unit role NJK::AST;

method gist {
  qq:to/END/;
  { self.^name }:
  {
    self.^attributes.map({
      "- {
        .name.substr: 2
      }:\n{
        self."{ .name.substr: 2 }"().map({ .defined ??.gist !! "" }).indent(4)
      }".indent: 4
    }).join: "\n"
  }
  END
}
