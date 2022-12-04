
function wardleyNouns() {
    // create an array with following words
    // competitive advantage, learning organization, big data, growth, value, digital business, revolution, culture, ecosystem, internet of things, insight from data, virtual reality, artificial intelligence, blockchain, design thinking, digital transformation
    // and return the array


    // create an array with following words
    var words = ["competitive advantage", "learning organization", "big data", "growth", "value", "digital business", "revolution", "culture", "ecosystem", "internet of things", "insight from data", "virtual reality", "artificial intelligence", "blockchain", "design thinking", "digital transformation"];
    // and return the array
    return words;
}

function wardleyPluralNouns() {
    //create an with following words
    //social media leaders, data leaders, digital leaders
    // and return the array

    //create an with following words
    var words = ["social media leaders", "data leaders", "digital leaders", "technology leaders", "hands-on leaders", "passionate leaders"];
    // and return the array
    return words;

}

function wardleyAdjectives() {
    //create an with following words
    //digital first, agile, open, innovative, efficient, collaborative, networked, customer focused, disruptive, sustainable, culture driven
    // and return the array

    //create an with following words
    var words = ["digital first", "agile", "open", "innovative", "efficient", "collaborative", "networked", "customer focused", "disruptive", "sustainable", "culture driven", "cloud based", "secure", "platform first"];
    // and return the array
    return words;

}
function wardleyStrategyGenerator() {
    // take following sentence and templatize with
    //Our strategy is <%=adjective%>. We will lead <%=indef_adjective%> effort of the market through our use of <%=noun%> and <%=plural_noun%> to build <%=indef_noun%>. By being both <%=adjective%> and <%=adjective%>, our <%=adjective%> approach will drive <%=noun%> throughout the organization. Synergies between our <%=noun%> and <%=noun%> will enable us to capture the upside by becoming <%=adjective%> in <%=indef_adjective%> world. These transformations combined with <%=noun%> due to our <%=plural_noun%> will create <%=indef_noun%> through <%=noun%> and <%=plural_noun%>.
    // and insert unique random words from array into string template and return the string

    // take following sentence and templatize with
    var template = "Our strategy is <%=adjective%>. We will lead <%=indef_adjective%> effort of the market through our use of <%=noun%> and <%=plural_noun%> to build <%=indef_noun%>. By being both <%=adjective%> and <%=adjective%>, our <%=adjective%> approach will drive <%=noun%> throughout the organization. Synergies between our <%=noun%> and <%=noun%> will enable us to capture the upside by becoming <%=adjective%> in <%=indef_adjective%> world. These transformations combined with <%=noun%> due to our <%=plural_noun%> driven mission-oriented approach will create <%=indef_noun%> through <%=noun%> and <%=plural_noun%>.";
    // and insert unique random words from array into string template and return the string


    var nouns = wardleyNouns();
    var pluralNouns = wardleyPluralNouns();
    var adjectives = wardleyAdjectives();
    var result = template.replace(/<%=adjective%>/g, function () {
        return adjectives.splice(Math.floor(Math.random() * adjectives.length), 1);
    });
    result = result.replace(/<%=indef_adjective%>/g, function () {
        return generateIndefiniteArticlePrefix(adjectives.splice(Math.floor(Math.random() * adjectives.length), 1));
    });
    result = result.replace(/<%=noun%>/g, function () {
        return nouns.splice(Math.floor(Math.random() * nouns.length), 1);
    });
    result = result.replace(/<%=plural_noun%>/g, function () {
        return pluralNouns.splice(Math.floor(Math.random() * pluralNouns.length), 1);
    });
    result = result.replace(/<%=indef_noun%>/g, function () {
        return nouns.splice(Math.floor(Math.random() * nouns.length), 1);
    });


    return result;

}

function generateIndefiniteArticlePrefix(inputWord) {

    let testString = inputWord.toString();
    // check if input word starts with vowel
    if (testString.toLowerCase().at(0) === 'a' || testString.toLowerCase().at(0) === 'e' || testString.toLowerCase().at(0) === 'i' || testString.toLowerCase().at(0) === 'o' || testString.toLowerCase().at(0) === 'u') {
        // if it starts with vowel then return "an"
        return "an " + inputWord;
    } else {
        // if it starts with consonant then return "a"
        return "a " + inputWord;
    }


}

