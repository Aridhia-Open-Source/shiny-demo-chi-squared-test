xap.require(
  "shiny",
  "shinyAce",
  "pwr",
  "vcd"
)

source("aceReadCsv.R")
source("goodnessOfFitTest.R")
source("printSessionInfo.R")
source("testOfIndependence.R")

shinyUI(bootstrapPage(
  
  headerPanel("Chi-square Test"),
  
  ########## Adding loading message #########
  
  tags$head(tags$style(type="text/css", "
                       #loadmessage {
                       position: fixed;
                       top: 0px;
                       left: 0px;
                       width: 100%;
                       padding: 10px 0px 10px 0px;
                       text-align: center;
                       font-weight: bold;
                       font-size: 100%;
                       color: #000000;
                       background-color: #CCFF66;
                       z-index: 105;
                       }
                       ")),
  
  conditionalPanel(condition="$('html').hasClass('shiny-busy')",
                   tags$div("Loading...",id="loadmessage")),
  
  ########## Added up untill here ##########
  
  mainPanel(
    tabsetPanel(position = "left", selected = "Test of Independence (Tabulated data)",
                tabPanel("Test of goodness of fit (Raw data)",
                         h2("Test of goodness of fit (Raw data)"),
                         h4("One nominal variable"),
                         #p('Note: Input values must be separated by tabs. Copy and paste from Excel/Numbers.'),
                         #p(HTML("<b><div style='background-color:#FADDF2;border:1px solid black;'>Your data needs to have the header (variable names) in the first row. Missing values should be indicated by a period (.) or NA.</div></b>")),
                         #aceEditor("text1", value="L1\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese", mode="r", theme="cobalt"),
                         aceReadCsvUI("gof_raw", paste0("L1\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\n",
                                      "Japanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\n",
                                      "Japanese\nJapanese\nJapanese\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\n",
                                      "Thai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\n",
                                      "Thai\nThai\nThai\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\n",
                                      "Chinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\n",
                                      "Chinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\n",
                                      "Chinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\n",
                                      "Chinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\n",
                                      "Chinese\nChinese\nChinese\nChinese\nChinese")),
                         br(),
                         goodnessOfFitTestUI("gof_test_raw"),
                         printSessionInfoUI("info1")
                ),
                
                tabPanel("Test of goodness of fit (Tabulated data)",
                         h2("Test of goodness of fit (Tabulated data)"),
                         h4("One nominal variable"),
                         #p('Note: Input values must be separated by tabs. Copy and paste from Excel/Numbers.'),
                         #p(HTML("<b><div style='background-color:#FADDF2;border:1px solid black;'>Your data needs to have the header (variable names) in the first row. Missing values should be indicated by a period (.) or NA.</div></b>")),
                         #aceEditor("text2", value="Japanese\tThai\tChinese\n18\t24\t48", mode="r", theme="cobalt"),
                         aceReadCsvUI("gof_tab", placeholder = "Japanese,Thai,Chinese\n18,24,48"),
                         br(),
                         goodnessOfFitTestUI("gof_test_tab"),
                         printSessionInfoUI("info2")
                ),
                
                tabPanel("Test of Independence (Raw data)",
                         h2("Test of Independence (Raw data)"),
                         h4("Two or more than two nominal variables"),
                         # p('Note: Input values must be separated by tabs. Copy and paste from Excel/Numbers.'),
                         # p(HTML("<b><div style='background-color:#FADDF2;border:1px solid black;'>Your data needs to have the header (variable names) in the first row. Missing values should be indicated by a period (.) or NA.</div></b>")),
                         # aceEditor("text3", value="Sex\tEffect\nM\tNo\nW\tNo\nW\tNo\nM\tNo\nM\tYes\nM\tYes\nM\tYes\nM\tNo\nW\tYes\nM\tNo\nW\tYes\nM\tNo\nM\tYes\nM\tNo\nM\tNo\nM\tYes\nW\tYes\nW\tYes\nW\tYes\nW\tYes\nW\tYes\nM\tYes\nM\tNo\nM\tNo\nM\tYes\nM\tYes\nW\tYes\nM\tNo\nM\tYes\nW\tYes\nM\tNo\nM\tNo\nW\tYes\nW\tYes\nW\tYes\nW\tYes\nM\tNo\nW\tNo\nW\tYes\nM\tYes\nW\tYes\nM\tNo\nM\tYes\nW\tYes\nM\tYes\nW\tYes\nM\tYes\nM\tNo\nM\tNo\nW\tNo\nW\tNo\nM\tYes\nW\tNo\nM\tYes\nW\tYes\nW\tYes\nM\tNo\nM\tNo\nM\tYes\nW\tYes\nM\tNo\nW\tYes\nW\tYes\nM\tYes\nW\tNo\nW\tYes\nM\tNo\nW\tYes\nW\tNo\nM\tYes",mode="r", theme="cobalt"),
                         aceReadCsvUI("toi_raw", placeholder = paste0("Sex,Effect\nM,No\nW,No\nW,No\nM,No\nM,Yes\nM,Yes\n",
                                                                      "M,Yes\nM,No\nW,Yes\nM,No\nW,Yes\nM,No\nM,Yes\nM,No\n",
                                                                      "M,No\nM,Yes\nW,Yes\nW,Yes\nW,Yes\nW,Yes\nW,Yes\nM,Yes\n",
                                                                      "M,No\nM,No\nM,Yes\nM,Yes\nW,Yes\nM,No\nM,Yes\nW,Yes\n",
                                                                      "M,No\nM,No\nW,Yes\nW,Yes\nW,Yes\nW,Yes\nM,No\nW,No\n",
                                                                      "W,Yes\nM,Yes\nW,Yes\nM,No\nM,Yes\nW,Yes\nM,Yes\nW,Yes\n",
                                                                      "M,Yes\nM,No\nM,No\nW,No\nW,No\nM,Yes\nW,No\nM,Yes\n",
                                                                      "W,Yes\nW,Yes\nM,No\nM,No\nM,Yes\nW,Yes\nM,No\nW,Yes\n",
                                                                      "W,Yes\nM,Yes\nW,No\nW,Yes\nM,No\nW,Yes\nW,No\nM,Yes")
                                      ),
                         br(),
                         testOfIndependenceUI("toi_test_raw"),
                         printSessionInfoUI("info3")
                ),
                
                tabPanel("Test of Independence (Tabulated data)",
                         h2("Test of Independence (Tabulated data)"),
                         h4("Two or more than two nominal variables"),
                         # p('Note: Input values must be separated by tabs. Copy and paste from Excel/Numbers.'),
                         # p(HTML("<b><div style='background-color:#FADDF2;border:1px solid black;'>Your data needs to have the header (variable names) in the first row. Missing values should be indicated by a period (.) or NA.</div></b>")),
                         # aceEditor("text4", value="\tNo\tYes\nM\t20\t18\nW\t8\t24", mode="r", theme="cobalt"),
                         aceReadCsvUI("toi_tab", placeholder = ",No,Yes\nM,20,18\nW,8,24"),
                         br(),
                         testOfIndependenceUI("toi_test_tab"),
                         printSessionInfoUI("info4")
                ),
                
                tabPanel("About",
                         
                         strong('Note'),
                         p('This web application is developed with',
                           a("Shiny.", href="http://www.rstudio.com/shiny/", target="_blank"),
                           ''),
                         
                         br(),
                         
                         strong('List of Packages Used'), br(),
                         code('library(shiny)'),br(),
                         code('library(shinyAce)'),br(),
                         code('library(pwr)'),br(),
                         code('library(vcd)'),br(),
                         
                         br(),
                         
                         strong('Code'),
                         p('Source code for this application is based on',
                           a('"The handbook of Research in Foreign Language Learning and Teaching" (Takeuchi & Mizumoto, 2012).', href='http://mizumot.com/handbook/', target="_blank")),
                         
                         p('The code for this web application is available at',
                           a('GitHub.', href='https://github.com/mizumot/chi', target="_blank")),
                         
                         p('If you want to run this code on your computer (in a local R session), run the code below:',
                           br(),
                           code('library(shiny)'),br(),
                           code('runGitHub("chi","mizumot")')
                         ),
                         
                         p('I referred to',
                           a("js-STAR", href="http://www.kisnet.or.jp/nappa/software/star/", target="_blank"),
                           'for some parts of the codes. I would like to thank the authors of js-STAR, the very fast and excellent online software.'),
                         
                         br(),
                         
                         strong('Citation in Publications'),
                         p('Mizumoto, A. (2015). Langtest (Version 1.0) [Web application]. Retrieved from http://langtest.jp'),
                         
                         br(),
                         
                         strong('Article'),
                         p('Mizumoto, A., & Plonsky, L. (2015).', a("R as a lingua franca: Advantages of using R for quantitative research in applied linguistics.", href='http://applij.oxfordjournals.org/content/early/2015/06/24/applin.amv025.abstract', target="_blank"), em('Applied Linguistics,'), 'Advance online publication. doi:10.1093/applin/amv025'),
                         
                         br(),
                         
                         strong('Recommended'),
                         p('To learn more about R, I suggest this excellent and free e-book (pdf),',
                           a("A Guide to Doing Statistics in Second Language Research Using R,", href="http://cw.routledge.com/textbooks/9780805861853/guide-to-R.asp", target="_blank"),
                           'written by Dr. Jenifer Larson-Hall.'),
                         
                         p('Also, if you are a cool Mac user and want to use R with GUI,',
                           a("MacR", href="https://sites.google.com/site/casualmacr/", target="_blank"),
                           'is defenitely the way to go!'),
                         
                         br(),
                         
                         strong('Author'),
                         p(a("Atsushi MIZUMOTO,", href="http://mizumot.com", target="_blank"),' Ph.D.',br(),
                           'Associate Professor of Applied Linguistics',br(),
                           'Faculty of Foreign Language Studies /',br(),
                           'Graduate School of Foreign Language Education and Research,',br(),
                           'Kansai University, Osaka, Japan'),
                         
                         br(),
                         
                         a(img(src="http://i.creativecommons.org/p/mark/1.0/80x15.png"), target="_blank", href="http://creativecommons.org/publicdomain/mark/1.0/"),
                         
                         p(br())
                         
                )
    )
  )
  ))