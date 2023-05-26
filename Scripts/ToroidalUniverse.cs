using System.Collections;
using System.Collections.Generic;
using UnityEngine;


[System.Serializable]
public struct Borders
{
    public float superiorBorder, inferiorBorder, leftBorder, rightBorder;
}
public class ToroidalUniverse : MonoBehaviour
{
    public Borders border;
    // Update is called once per frame
    void Update()
    {
        var pos = transform.position;
        var x = transform.position.x;
        var y = transform.position.y;

        if (x > border.rightBorder)
        {
            pos.x = border.leftBorder;
            transform.position = pos;
        }
        if (x < border.leftBorder)
        {
            pos.x = border.rightBorder;
            transform.position = pos;
        }
        if (y > border.superiorBorder)
        {
            pos.y = border.inferiorBorder;
            transform.position = pos;
        }
        if (y < border.inferiorBorder)
        {
            pos.y = border.superiorBorder;
            transform.position = pos;
        }
    }
}
