package org.example.creational.factory;

public class WordDocument implements Document {
    private String content = "";

    @Override
    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public String getContent() {
        return content;
    }

    @Override
    public String getType() {
        return "WORD";
    }

    @Override
    public void open() {
        System.out.println("Opening Word document");
    }

    @Override
    public void save() {
        System.out.println("Saving Word document to .docx file");
    }

    @Override
    public String display() {
        return "[Word Document]\n" + content + "\n[End of Document]";
    }
}
