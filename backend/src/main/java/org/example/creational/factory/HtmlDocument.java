package org.example.creational.factory;

public class HtmlDocument implements Document {
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
        return "HTML";
    }

    @Override
    public void open() {
        System.out.println("Opening HTML document in browser");
    }

    @Override
    public void save() {
        System.out.println("Saving HTML document to .html file");
    }

    @Override
    public String display() {
        return "<html>\n<head><title>Document</title></head>\n<body>\n<p>" + content + "</p>\n</body>\n</html>";
    }
}
