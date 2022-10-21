---
# Hackerrank Python Notes
---

- When unpacking an iterable, if you place a * before the last variable, it will take all the remaining items to be unpacked and save them to that variable as a list
- lambda function syntax lambda x, y, z (parameters): x + y * z (function definition)
- try except --> try lets you test code block, except catches errors, you can name error whatever you want? (there are some built in exceptions), and you can write a print statement or whatever logic you want in the  except block
    - Can have multiple except blocks if different errors
    - Can have else block also that executes after try if no error
    - Can also have finally block that executes regardless of if they try block creates an error or not
    - Can also use raise keyword to create your own error given certain logic is satisfied
- *args as a parameter will pick up remaining entries in list as a list to be used in the function
- Convert list to tuple using tuple()
- Need to read and learn more about use cases for stdin and stdout