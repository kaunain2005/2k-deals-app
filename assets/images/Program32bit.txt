import { StyleSheet, Text, TouchableOpacity, View, Image } from "react-native";
import React from "react";

const NextButton = ({scrollTo,btnText}) => {
  return (
    <View style={styles.container}>
        <TouchableOpacity style={styles.btn} onPress={scrollTo}>
            <Text style={styles.btnText}>{btnText}</Text>
        </TouchableOpacity>
    </View>
  );
};

export default NextButton;

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  btn:{
    color: "#000",
    paddingHorizontal: 20,
    paddingVertical: 10,
    borderRadius: 10,
    borderColor: "#493d8a",
    borderWidth: 1,
    backgroundColor: "#493d8a",
  },
  btnText:{
    fontSize: 20,
    fontWeight: 'bold',
    color: "#fff",
  },
});
