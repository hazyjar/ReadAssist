img=imread('C:\Users\Yash Raj Gupta\Desktop\text.png');
result=ocr(img);
word=result.Words;
i=1;
len=length(word);
while i<=len;
    tts(word{i*5+j,1},[],0);
    i=i+1;
end 