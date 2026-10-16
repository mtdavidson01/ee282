# EE282 Homework 2

## Question 1

Navigate to the `homework2` directory you downloaded from the course website. Inside, there should be the files `this.txt` and `that.txt`. Using bash, complete the following:

1. Verify you have the `this.txt` and `that.txt` files in your `homework2` directory.
2. You've decided you may need a third file soon. Create an empty file named `the_other.txt`.
3. You find out `this.txt` is redundant, and the information within it is fully contained within `that.txt`. To clean up your directory:  
   * Delete `this.txt`
   * Rename `that.txt` to `this_and_that.txt`

## Answer 1

```
ls
touch the_other.txt
rm this.txt
mv that.txt this_and_that.txt
```

## Question 2

You have a matrix, `mymatrix`, and a dataframe, `mydf` in your R code that you go on to use for other analysis.

```
> mymatrix
     vector1 vector2
[1,] "a"     "W"    
[2,] "b"     "X"    
[3,] "c"     "Y"    
[4,] "d"     "Z"    

> mydf
  vector1 vector2
1       a       W
2       b       X
3       c       Y
4       d       Z
```

Eventually, you discover an error! When you investigate, you realize you were attempting to use only the data in column `vector1` of `mydf`, but subsetted it in a way that the output was in the form of a vector when your code expected it to be in the form of a dataframe.

1. Assuming you called column `vector1` by name, list three possible ways you could have subsetted `mydf` that returns the data in the form of a vector. 

2. Assuming you called column `vector1` by name, how could you have subsetted `mydf` to return the data in the form of a dataframe?

3. In a different portion of your code, you used `mymatrix[,'vector1']` when you meant to use `mydf[,'vector1']`. Might this cause problems with your code in this instance? Why or why not?

## Answer 2

1. ```
   mydf[, 'vector1']
   mydf$vector1
   mydf[['vector1']
   ```

2. `mydf$vector1`

3. No problems will occur, `mymatrix[,'vector1']` and `mydf[,'vector1']` return the same vector.

## Question 3

You woke up with a sore throat today and are having a hard time speaking, but do not want to lose your reputation as a very friendly labmate. To solve this problem, you decide to write a script called `sayHello`, which runs `echo "Hello $USER!"`, and share the filepath to it with your colleagues, `/pub/greetings/sayHello`. Make sure everyone has permission to use it, but only you an edit it, by assigning permissions with octals. Don't forget all parent directories must be executable!

## Answer 3

```
chmod -R 755 /pub/greetings/
chmod 755 /pub/greetings/sayHello
```
