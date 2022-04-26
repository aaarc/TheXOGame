class brains
{

  int _make_default_move(var arr,)
{
  int a=10;
  if(arr[4]==" ")
    {
      return 4;
    }
  else if(arr[2]==" "||( arr[0]=="x"&&arr[6]=="x"))
    {
      return 2;
    }
  else if(arr[6]==" " ||( arr[0]=="x"&&arr[2]=="x"))
    {
      return 6;
    }
  else if(arr[8]==" " ||( arr[6]=="x"&&arr[2]=="x"))
  {
    return 8;
  }


  for(int i=0;i<9;i++)
  {

    if(arr[i]==" ")
    {
      a = i;
      break;
    }
  }
  return a;
}
int Chk_user_won(var arr)
{
  if((arr[0]=="x" && arr[1]=="x"&& arr[2]=="x")||(arr[0]=="x" && arr[3]=="x" && arr[6]=="x")||(arr[0]=="x"&& arr[4]=="x" && arr[8]=="x")||(arr[3]=="x" && arr[4]=="x" && arr[5]=="x")||(arr[2]=="x" && arr[4]=="x" && arr[6]=="x")||(arr[1]=="x" && arr[4]=="x" && arr[7]=="x")||(arr[2]=="x" && arr[5]=="x" && arr[8]=="x")||(arr[6]=="x"&& arr[7]=="x"&& arr[8]=="x"))
  {
    return 1;
  }
  else if((arr[0]=="o" && arr[1]=="o"&& arr[2]=="o")||(arr[0]=="o"&& arr[3]=="o"&& arr[6]=="o")||(arr[0]=="o"&& arr[4]=="o" && arr[8]=="o")||(arr[3]=="o" && arr[4]=="o" && arr[5]=="o")||(arr[2]=="o" && arr[4]=="o" && arr[6]=="o")||(arr[1]=="o" && arr[4]=="o" && arr[7]=="o")||(arr[2]=="o" && arr[5]=="o" && arr[8]=="o")||(arr[6]=="o"&& arr[7]=="o"&& arr[8]=="o"))
  {
    return 0;
  }
  else if(Check_Game_over(arr))
  {
    return 2;
  }
  else
  {
    return 3;
  }
}


bool Check_Game_over(var arr)
{
  var counter=0;
  for(var x in arr)
  {
    if(x==" ")
    {
      counter=counter+1;
    }
  }
  if(counter==0)
  {
    return true;
  }
  else
  {
    return false;
  }

}

int mk_move(var arr)
{
  if((arr[0]=='o'&& arr[1]==" " && arr[2]=="o")||(arr[4]=='o'&& arr[1]==" " && arr[7]=="o"))//for element 1
      {
    return 1;
  }
  else if((arr[1]=='o'&& arr[0]==" " && arr[2]=="o")||(arr[3]=='o'&& arr[0]==" " && arr[6]=="o")||(arr[4]=='o'&& arr[0]==" " && arr[8]=="o"))// for element 0
      {
    return 0;
  }
  else if((arr[0]=='o'&& arr[2]==" " && arr[1]=="o")||(arr[4]=='o'&& arr[2]==" " && arr[6]=="o")||(arr[5]=='o'&& arr[2]==" " && arr[8]=="o")) // for element 2
      {
    return 2;
  }
  else if((arr[0]=='o'&& arr[3]==" " && arr[6]=="o")||(arr[4]=='o'&& arr[3]==" " && arr[5]=="o"))// for element 3
      {
    return 3;
  }
  else if((arr[3]=='o'&& arr[4]==" " && arr[5]=="o")||(arr[0]=='o'&& arr[4]==" " && arr[8]=="o")||(arr[2]=='o'&& arr[4]==" " && arr[6]=="o")||(arr[1]=='o'&& arr[4]==" " && arr[7]=="o"))// for element 4
      {
    return 4;
  }
  else if((arr[3]=='o'&& arr[5]==" " && arr[4]=="o")||(arr[2]=='o'&& arr[5]==" " && arr[8]=="o"))// for element 5
      {
    return 5;
  }
  else if((arr[0]=='o'&& arr[6]==" " && arr[3]=="o")||(arr[7]=='o'&& arr[6]==" " && arr[8]=="o")||(arr[2]=='o'&& arr[6]==" " && arr[4]=="x"))// for element 6
      {
    return 6;
  }
  else if((arr[1]=='o'&& arr[7]==" " && arr[4]=="o")||(arr[6]=='o'&& arr[7]==" " && arr[8]=="o"))// for element 7
      {
    return 7;
  }
  else if((arr[0]=='o'&& arr[8]==" " && arr[4]=="o")||(arr[6]=='o'&& arr[8]==" " && arr[7]=="o")||(arr[2]=='o'&& arr[8]==" " && arr[5]=="o"))// for element 8
      {
    return 8;
  }
  else if((arr[0]=='x'&& arr[1]==" " && arr[2]=="x")||(arr[4]=='x'&& arr[1]==" " && arr[7]=="x"))//for element 1
      {
    return 1;
  }
  else if((arr[1]=='x'&& arr[0]==" " && arr[2]=="x")||(arr[3]=='x'&& arr[0]==" " && arr[6]=="x")||(arr[4]=='x'&& arr[0]==" " && arr[8]=="x"))// for element 0
      {
    return 0;
  }
  else if((arr[0]=='x'&& arr[2]==" " && arr[1]=="x")||(arr[4]=='x'&& arr[2]==" " && arr[6]=="x")||(arr[5]=='x'&& arr[2]==" " && arr[8]=="x")) // for element 2
      {
    return 2;
  }
  else if((arr[0]=='x'&& arr[3]==" " && arr[6]=="x")||(arr[4]=='x'&& arr[3]==" " && arr[5]=="x"))// for element 3
      {
    return 3;
  }
  else if((arr[3]=='x'&& arr[4]==" " && arr[5]=="x")||(arr[0]=='x'&& arr[4]==" " && arr[8]=="x")||(arr[2]=='x'&& arr[4]==" " && arr[6]=="x")||(arr[1]=='x'&& arr[4]==" " && arr[7]=="x"))// for element 4
      {
    return 4;
  }
  else if((arr[3]=='x'&& arr[5]==" " && arr[4]=="x")||(arr[2]=='x'&& arr[5]==" " && arr[8]=="x"))// for element 5
      {
    return 5;
  }
  else if((arr[0]=='x'&& arr[6]==" " && arr[3]=="x")||(arr[7]=='x'&& arr[6]==" " && arr[8]=="x")||(arr[2]=='x'&& arr[6]==" " && arr[4]=="x"))// for element 6
      {
    return 6;
  }
  else if((arr[1]=='x'&& arr[7]==" " && arr[4]=="x")||(arr[6]=='x'&& arr[7]==" " && arr[8]=="x"))// for element 7
      {
    arr[7]='o';
    return 7;
  }
  else if((arr[0]=='x'&& arr[8]==" " && arr[4]=="x")||(arr[6]=='x'&& arr[8]==" " && arr[7]=="x")||(arr[2]=='x'&& arr[8]==" " && arr[5]=="x"))// for element 8
      {
    return 8;
  }
  else
  {
    int a;
    a=_make_default_move(arr);
    if(a==10)
    {
      print("Unexpected error has occured");

    }
    else
    {
      return a;
    }
  }
  return 0;
}
}