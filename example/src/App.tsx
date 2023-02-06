import * as React from 'react';

import { StyleSheet, View, Text } from 'react-native';

export default function App() {
  return (
    <View style={styles.container}>
      <Text style={styles.wavyText}>A wavy Text</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  wavyText: {
    fontSize: 24,
    height: 32,
    textDecorationColor: 'red',
    textDecorationLine: 'underline',
    textDecorationStyle: 'wavy',
    
  }
});
