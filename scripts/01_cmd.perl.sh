### (1)Usually, there should be a scripts or src folder at your home directory, top level if not  do mkdir ~/scripts   
cd ~/scripts/

### (2)You need to install git to be able to run below command. https://git-scm.com/book/en/v2/Getting-Started-Installing-Git    
git clone https://github.com/umngao/rust_scores_conversion.git

### (3)move to the GIT directory and checkout the corresponding versions of the rust script conversion scripts. You don't have to do this step, if you simply want to use the most current version of scripts
cd rust_scores_conversion
git checkout a8c1931  
### and if you accidentally did something stupid. You have a couple of options   
### i: Delete the git clone folder that you are currently in and redo git clone and start over. or   
### ii: Do "git checkout master" to use the most current version    
### iii: Do  "git branch --all" and  "git branch -d "YOURBRANCH_ID"" to delete some branches that you don't like. Hopefully that solves the problem....  


### (4) cd to your project folder and run commands. The input of the perl program needs to be tab delimited file.  
cd /cygdrive/d/Dropbox/05_publications/Gao_Zelma
rust_script="$HOME/scripts/rust_scores_conversion/convert_rust_reading.seedling.pl"
my_typo="$HOME/scripts/rust_scores_conversion/sample_data_seedling/typo.seedling.txt"
my_pheno='sr15datadump/old_data/20170628_Table1_orig.txt'
columns='1,2,3,4,5,6,7,8'
perl $rust_script --typo $my_typo --pheno $my_pheno --columns $columns


### after this step, you will get an output file named 'YOURE_PREVIOUSE_NAME_out.txt'
### Proceed to R for statistical analysis and visulizations.

