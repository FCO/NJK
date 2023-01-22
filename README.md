```
➜  NJK git:(main) raku -Ilib -MNJK::Grammar -MNJK::Actions -e '
dd NJK::Grammar.parse(:actions(NJK::Actions), q|<a href="pudim.com.br">pudim</a><br>test!<br>{{ "test" }}{{ 1 + 1 * 1 - 1 / 1 }}|).ast;
'
NJK::AST::Unit.new(parts => Array[NJK::AST].new(NJK::AST::HTMLTagBody.new(tag-name => "a", params => {:href("pudim.com.br")}, body => Array[NJK::AST].new(NJK::AST::HTMLText.new(value => "pudim"))), NJK::AST::HTMLTagVoid.new(tag-name => "br", params => {}), NJK::AST::HTMLText.new(value => "test!"), NJK::AST::HTMLTagVoid.new(tag-name => "br", params => {}), NJK::AST::Value.new(value => NJK::AST::LogicQuoted.new(value => "test", double => Bool::True)), NJK::AST::Value.new(value => NJK::AST::LogicInfixOp.new(left => NJK::AST::LogicNumeric.new(value => 1), right => NJK::AST::LogicInfixOp.new(left => NJK::AST::LogicNumeric.new(value => 1), right => NJK::AST::LogicInfixOp.new(left => NJK::AST::LogicNumeric.new(value => 1), right => NJK::AST::LogicInfixOp.new(left => NJK::AST::LogicNumeric.new(value => 1), right => NJK::AST::LogicNumeric.new(value => 1), op => "/"), op => "-"), op => "*"), op => "+"))))

➜  NJK git:(main) raku -Ilib -MNJK::Grammar -MNJK::Actions -e '
say NJK::Grammar.parse(:actions(NJK::Actions), q|<a href="pudim.com.br">pudim</a><br>test!<br>{{ "test" }}{{ 1 + 1 * 1 - 1 / 1 }}|).ast;
'
NJK::AST::Unit:
    - parts:
        NJK::AST::HTMLTagBody:
            - tag-name:
                a
            - params:
                href	pudim.com.br
            - body:
                NJK::AST::HTMLText:
                    - value:
                        pudim

         NJK::AST::HTMLTagVoid:
            - tag-name:
                br
            - params:

         NJK::AST::HTMLText:
            - value:
                test!
         NJK::AST::HTMLTagVoid:
            - tag-name:
                br
            - params:

         NJK::AST::Value:
            - value:
                NJK::AST::LogicQuoted:
                    - value:
                        test
                    - double:
                        True

         NJK::AST::Value:
            - value:
                NJK::AST::LogicInfixOp:
                    - left:
                        NJK::AST::LogicNumeric:
                            - value:
                                1

                    - right:
                        NJK::AST::LogicInfixOp:
                            - left:
                                NJK::AST::LogicNumeric:
                                    - value:
                                        1

                            - right:
                                NJK::AST::LogicInfixOp:
                                    - left:
                                        NJK::AST::LogicNumeric:
                                            - value:
                                                1

                                    - right:
                                        NJK::AST::LogicInfixOp:
                                            - left:
                                                NJK::AST::LogicNumeric:
                                                    - value:
                                                        1

                                            - right:
                                                NJK::AST::LogicNumeric:
                                                    - value:
                                                        1

                                            - op:
                                                /

                                    - op:
                                        -

                            - op:
                                *

                    - op:
                        +


```
