use NJK::Type;
unit role NJK::Grammar::Macro;

rule statement:sym<macro> {
  :my %local := CALLERS::<%*VARIABLES>;
  :my %*PARENT-VARIABLES = |CALLERS::<%*VARIABLES>, |CALLERS::<%*PARENT-VARIABLES>.?pairs;
  :my %*VARIABLES;
  <njk-block(
    "macro",
    /<macro-prototype>/,
  )>
  {
    my $proto = $<njk-block><opening-tag><regex><macro-prototype>;
    my $func-type = "function({
      $proto<positional-params>.map({
        (.<type> // "any").Str;
      }).join: ", "
    })";
    %local{ $proto<macro-name> } = NJK::Type.new: $func-type
  }
}

rule macro-prototype {
  <macro-name=.var-name> "(" ~ ")" <positional-params=.declare-var>* % [<.ws> ',' <.ws>]
}
