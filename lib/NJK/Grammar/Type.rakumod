unit role NJK::Grammar::Type;

rule type {
  <type-opt>+ %% "|"
}

rule type-opt {
  <type-name> [ "[" ~ "]" <type>]?
}

proto token type-name             { *      }
      token type-name:sym<any>    { <.sym> }
      token type-name:sym<string> { <.sym> }
      token type-name:sym<number> { <.sym> }
      token type-name:sym<array>  { <.sym> }
      token type-name:sym<object> { <.sym> }
