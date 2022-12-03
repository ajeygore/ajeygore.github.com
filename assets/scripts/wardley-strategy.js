function wardleyStrategy() {
  // create an array with following words
    // digital first, agile, open, innovative, efficiency, competitive advantage, ecosystem, networked, collaborative,  learning organisation, social media, revolution, cloud based, big data, secure, internet of things, growth, value, customer focused, digital business, disruptive, data leaders, big data, insight from data, platform, sustainable, revolution, culture.
    // and create a string template with following sentence
    // Our strategy is [..]. We will lead a [..] effort of the market through our use of [..] and [..]  to build a [..]. By being both [..] and [..], our [..] approach will drive [..] throughout the organisation. Synergies between our [..] and [..] will enable us to capture the upside by becoming [..] in a [..] world. These transformations combined with [..] due to our [..] will create a [..] through [..] and [..].
    // and insert unique random words from array into string template and return the string

    // create an array with following words
    var words = ["digital first", "agile", "open", "innovative", "efficiency", "competitive advantage", "ecosystem", "networked", "collaborative", "learning organisation", "social media", "revolution", "cloud based", "big data", "secure", "internet of things", "growth", "value", "customer focused", "digital business", "disruptive", "data leaders", "big data", "insight from data", "platform", "sustainable", "revolution", "culture driven"];
    // and create a string template with following sentence
    //"Our strategy is [..]. We will lead a [..] effort of the market through our use of [..] and [..]  to build a [..]. By being both [..] and [..], our [..] approach will drive [..] throughout the organisation. Synergies between our [..] and [..] will enable us to capture the upside by becoming [..] in a [..] world. These transformations combined with [..] due to our [..] will create a [..] through [..] and [..].";
    var template = "Our strategy is [..]. We will lead a [..] effort of the market through our use of [..] and [..]  to build a [..] business. By being both [..] and [..], our [..] approach will drive [..] throughout the organisation. Synergies between our [..] and [..] will enable us to capture the upside by becoming [..] in a [..] world. These transformations combined with [..] due to our [..] will create a [..] through [..] and [..].";
    // and insert unique random words from array into string template and return the html with words in bold
    var result = template.replace(/\[\.\.\]/g, function() { return words.splice(Math.floor(Math.random() * words.length), 1); });
    return result;


    // and insert unique random words from array into string template and return the string

}

function wardleyWords(){
    // create an array with following words
    // digital first, agile, open, innovative, efficiency, competitive advantage, ecosystem, networked, collaborative,  learning organisation, social media, revolution, cloud based, big data, secure, internet of things, growth, value, customer focused, digital business, disruptive, data leaders, big data, insight from data, platform, sustainable, revolution, culture.
    // and return the array

    // create an array with following words
    var words = ["digital first", "agile", "open", "innovative", "efficiency", "competitive advantage", "ecosystem", "networked", "collaborative", "learning organisation", "social media", "revolution", "cloud based", "big data", "secure", "internet of things", "growth", "value", "customer focused", "digital business", "disruptive", "data leaders", "big data", "insight from data", "platform", "sustainable", "revolution", "culture"];
    // and return the array
    return words;
}