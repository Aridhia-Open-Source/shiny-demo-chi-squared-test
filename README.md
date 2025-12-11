# CHI-SQUARED TEST

**Chi-squared test** is the most popular discrete data hypothesis testing method. It consists of the goodness of fit and the test of independence.    

The **Chi-squared goodness of fit test** is a non-parametric test that is used to determine whether there is a statistically significant difference between the expected frequencies and the observed frequencies in one or more categories of a contingency table.

The **Chi-squared test of independence** is used to determinate if there's a significant relationship between two nominal or categorical variables. The frequency of each category for one nominal variable is compared across the categories of the second variable.

## About the Chi-squared test app

Click on the relevant tab for the test you wish to perform. From there, in the left-hand sidebar, you can select which data source to use (file, raw or tabular). When selecting variables, be sure to select NOMINAL variables only. If numeric variable such as age are selected, each category will have a count of 1, and outputs will not display correctly and will not make sense.

The two types of Chi-squared tests you can perform on this app are located in two different tabs:

1. Goodness of fit. Use the drop-down menu to pick a first and second nominal variable, then select the values of interest which appear below the drop-down menus for each.
2. Test of independence. Use the drop-down menu to pick a first and second nominal variable, then select the values of interest which appear below the drop-down menus for each.

The examplar files used in this mini-app are located in the 'data' folder, you can save you own files there to use them in the mini-app.

### Checkout and run

You can clone this repository by using the command:

```
git clone https://github.com/Aridhia-Open-Source/shiny-demo-chi-squared-test
```

Open the .Rproj file in RStudio and use `runApp()` to start the app.

### Deploying to the workspace

1. Download this GitHub repo as a .zip file.
2. Create a new blank R web app in your workspace called "chi-squared-test".
3. Navigate to the `chi-squared-test` folder under "files".
4. Delete the `app.R` file from the `chi-squared-test` folder. Make sure you keep the `.version` file!
5. Upload the .zip file to the `chi-squared-test` folder.
6. Extract the .zip file. Make sure "Folder name" is blank and "Remove compressed file after extracting" is ticked.
7. Navigate into the unzipped folder.
8. Select all content of the unzipped folder, and move it to the `chi-squared-test` folder (so, one level up).
9. Delete the now empty unzipped folder.
10. Start the R console and run the `dependencies.R` script to install all R packages that the app requires.
11. Run the app in your workspace.

For more information visit https://knowledgebase.aridhia.io/article/how-to-upload-your-mini-app/
