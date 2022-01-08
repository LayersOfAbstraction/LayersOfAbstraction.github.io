---
layout: post
title: "Assigning Users In ASP.NET Core MVC 6 with DataTables Editor"
published: false
---

# Understanding Khan Academy's logarithms #

We have learned that to master Logarithms we need to understand Negative Exponents.

Anyway I have a simple exponent equation which can look like x ^y^ where x is 2 and y is 4.
So 2^4^ can be solved by multiplying the number 2 * 2 * 2 * 2 which equals 16.

Now we want to know what the power is that raises 2 to 16. We want to do the inverse operation.

So think of a new equation. 2^x = 16. We want to know what x is. That's where Logarithms come in. Figuring out what power we raise the base number (first number in the equation) to another number.

We can denote this with the Logarithms notation.

log 2 16 = x.

We still haven't figured out what x is yet. To figure it out we keep multiplying 2 until we arrive at the base of 16. Just like with exponents 2 * 2 * 2 * 2 = 16.

And as you can see there are 4 lots of 2s. So it would mean that 2^4=16. So it would mean that x is 4.

log 2 16 = 4! So we found out what power we had to raise base 2 to get to 16 which is 4.

Lets do that in the 100s or to be more exact lets do that with 216.

log 6 216 = x. Let's find out to which power to raise x to equate to 216 * 

6^1 = 6
6^2 = 36.
6^3 = 216 or 6 * 6 * 6* = 216.

What number of 6 did we have to raise to the power of to get to 216? 3. Meaning x is 3. 
If you are still unclear you can enter the numbers into Microsoft's great calculator so you could enter that into your calculator verbatim.

https://mathsolver.microsoft.com/en/solve-problem/%60log_%7B%206%20%20%7D(%7B%20216%20%20%7D)

Another here. log 100 1 = x. What is x? Anything with a zero power like 100 is equal to 0 if 100 x = 1. So x = 0. Really Log base... anything of 1 is going to be 0 as anything to the 0 power is going to be equal to 1.

## Base syntax ##

Just to note what the definition is of the Logarithm:

log b (a) = e ⟺  b e = a

b = base.
c = exponent and
a = argument.

This one is more challenging to understand.

log 8 2 = x.

Let's do it in exponent form. 8^x^ = 2. So this seems weird, how can 8 be raised to 2??

Well if 2^3^ = 8 then 8^1/3^ = 2 So we are essentially doing division as the base number is higher than the argument in Logarithmic form.

If that was confusing this can help. We increment the power by a fraction until...

8 ^1/1^ = 8

8 ^1/2^ = 2.828427125

8 ^1/3^ = 2

Try each formula on your calculator here if it still doesn't make sense.

<https://mathsolver.microsoft.com/en/solve-problem/%7B%208%20%20%7D%5E%7B%20%20%60frac%7B%201%20%20%7D%7B%202%20%20%7D%20%20%20%20%7D>

So if x is 1/3 than that means log 8 2 = 1/3.  

## Relationship between exponentials & logarithms: graphs ##

When we look at this image we will notice that on the graph we have 3 values present.

<img src="/images/UnderstandingKhanAcademy'sLogarithms/Relationshipbetweenexponentials&logarithmsgraphs.png" class="image fit" alt="Relationship between exponential & logarithms graphs"/>
We have y = bx.

So if you look at the <span style="color:green"> half green</span> and <span style="color:deeppink"> half pink dot</span> on the y axis you will notice that it is equal to 1. While x = 0.

The <span style="color:purple"> purple dot</span> a on the y axis is equal to 4 and on the x axis it is equal to 1.

The <span style="color:green"> green dot</span> on the y axis is equal to 16 and on the x axis it is equal to 2.  

So in total we have these values in our table.

| x | y= b^x^|
|---|--------|
| 0 | 1      |
| 1 | 4      |
| 2 | 16     |

Now we can deal with the inverse function of the exponent (i.e) what is expected. Log is the inverse of exponent. All we are doing in this table is swapping the x and y. 

| x | y= b^x^       |
|---|---------------|
| 1 | log ^b^ 1 = ? |

So now we want to know what the definition of log ^b^ 1. The <span style="color:green"> half green</span> and <span style="color:deeppink"> half pink dot.</span>

We need to know what was the first power we had to increment b to get to 1. If we assume b is not 0 which is a reasonable assumption because
b is to different powers are non zero.

<img src="/images/UnderstandingKhanAcademy'sLogarithms/Relationshipbetweenexponentials&logarithmsgraphs.png" class="image fit" alt="Relationship between exponential & logarithms graphs"/>

If that didn't make sense then we will do the next equation. So we need to do log b ^4^. As in work out how we raised be to 4. So on the graph you can see the <span style="color:purple"> purple dot</span>. 
As you can see it is on the x axis of 4 and y axis of 1 so log ^b^ 4 = 1. 

When illustrating that on the axis, it would look like this.
![](Relationship%20between%20exponentials%20&%20logarithms%20graphs_y_equals_Log_b_of_x_2.png)

So if it is making sense then we just get the inverse 4 on the x axis. 


Here is the table showing what each value equals arithmetically 

| x | y= b^x        |
|---|---------------|
| 1 | log ^b^ 1 = 0 |
| 4 | log ^b^ 4 = 1 |
| 16| log ^b^16 = ? |

I will let you figure out the last value and how you could possibly solve it yourself. Remember to try them both in exponential and logarithmic form.

## Relationship between exponentials & logarithms: tables ##

This can actually be surprisingly easy when you start comparing the values in both tables.
Here we must use our powers of deduction. We have to find out what the letters in both tables a b c and d mean. The only way to do that is by looking for example at the first column in the first table.

<img src="/images/UnderstandingKhanAcademy'sLogarithms/Relationshipbetweenexponentials&logarithmsgraphs.png" class="image fit" alt="Relationship between exponential & logarithms graphs"/>

Let's start with the letter a. Ask yourself what we have done previously when faced with the value 0. Say we increment 5^0^. What will be the result? 1. It will be like that no matter what number we use. So the letter 'a' to the power of 0 = 1.

You could figure this out very easily on the calculator but I hope you gave it a try because I never did any high schooling and have no maths background so if I could figure this out and make a blog out of this chance are you can too!

Notice these 2 match? I didn't even use a calculator. I just matched those 2 values and then used the calculator.

Let's do this log2^3.0^ = 1.585. Yes I know they had one of the numbers wrong in the diagram when you compare it to the calculator in logarithmic form. Now let's do it inverse of that operation which is the exponential format.

<img src="/images/UnderstandingKhanAcademy'sLogarithms/Relationshipbetweenexponentials&logarithms-tables-circled.png" class="image fit" alt="Relationship between exponential & logarithms graphs"/>

2^1.585^ = 3.000077979.

You can already see 3.0 so it should make enough sense. Another thing if we divide both sides by 2 then it will equal 1.5.

I will let you figure out what ^b^ means in the following equation log ^b^ 10d = 2.322.

## 𝑒 and compound interest ##